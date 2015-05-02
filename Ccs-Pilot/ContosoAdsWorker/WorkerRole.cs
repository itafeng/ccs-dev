using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.Diagnostics;
using Microsoft.WindowsAzure.ServiceRuntime;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Auth;
using Microsoft.WindowsAzure.Storage.Queue;
using Microsoft.WindowsAzure.Storage.Table;
using System.Configuration;
using ContosoAdsCommon;

namespace ContosoAdsWorker
{
    public class WorkerRole : RoleEntryPoint
    {
        public CloudStorageAccount storageAccount;
        public CloudTableClient tableClient;
        public CloudTable table;
        public CloudQueue msgQueue;
        
        public override void Run()
        {
            Trace.TraceInformation("Worker Role is running");
            CloudQueueMessage msg = null;

            while (true)
            {
                try
                {
                    msg = this.msgQueue.GetMessage();
                    if (msg != null)
                    {
                        RetrieveSystemInfo(msg);
                    }
                    else
                    {
                        System.Threading.Thread.Sleep(1000);
                    }
                }
                catch (StorageException e)
                {
                    if (msg != null && msg.DequeueCount > 5)
                    {
                        this.msgQueue.DeleteMessage(msg);
                        Trace.TraceError("Deleting poison queue item: '{0}'", msg.AsString);
                    }
                    Trace.TraceError("Exception in ContosoAdsWorker: '{0}'", e.Message);
                    System.Threading.Thread.Sleep(5000);
                }
            }
        }

        public void RetrieveSystemInfo(CloudQueueMessage msg)
        {
            try
            {
                CustomerEntity data1 = new CustomerEntity("Tom", "Cruise");
                data1.Name = "Role Instance Name";
                data1.Value = RoleEnvironment.CurrentRoleInstance.Role.ToString();

                CustomerEntity data2 = new CustomerEntity("Tom", "Smith");
                data2.Name = "Role Instance ID";
                data2.Value = RoleEnvironment.CurrentRoleInstance.Id.ToString();

                CustomerEntity data3 = new CustomerEntity("Tom", "Tucker");
                data3.Name = "Role Name";
                data3.Value = RoleEnvironment.CurrentRoleInstance.Role.ToString();

                CustomerEntity data4 = new CustomerEntity("Tom", "Zhou");
                data4.Name = "Fault Domain";
                data4.Value = RoleEnvironment.CurrentRoleInstance.FaultDomain.ToString();

                // Create the batch operation
                TableBatchOperation batchOperation = new TableBatchOperation();

                batchOperation.Insert(data1);
                batchOperation.Insert(data2);
                batchOperation.Insert(data3);
                batchOperation.Insert(data4);

                table.ExecuteBatch(batchOperation);

                // Remove message from queue
                this.msgQueue.DeleteMessage(msg);

            }
            catch (Exception e)
            {
                Trace.TraceError("Exception in RetrieveSystemInfo function: {0}", e.Message);
            }
        }

        public override bool OnStart()
        {
            // Set the maximum number of concurrent connections
            ServicePointManager.DefaultConnectionLimit = 12;

            // For information on handling configuration changes
            // see the MSDN topic at http://go.microsoft.com/fwlink/?LinkId=166357.


            // Retrieve storage account
            storageAccount = CloudStorageAccount.Parse(CloudConfigurationManager.GetSetting("StorageConnectionString"));

            //Create a table client
            tableClient = storageAccount.CreateCloudTableClient();

            // Create table
            table = tableClient.GetTableReference("system");
            table.CreateIfNotExists();
            
            // Create a queue
            CloudQueueClient queueClient = storageAccount.CreateCloudQueueClient();
            msgQueue = queueClient.GetQueueReference("message");
            msgQueue.CreateIfNotExists();

            Trace.TraceInformation("Worker Role has been started");
            
            bool result = base.OnStart();
            return result;
        }

    }
}
