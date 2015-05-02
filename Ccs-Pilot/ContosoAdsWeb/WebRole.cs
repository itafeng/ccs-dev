using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.Diagnostics;
using Microsoft.WindowsAzure.ServiceRuntime;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Auth;
using Microsoft.WindowsAzure.Storage.Table;
using Microsoft.WindowsAzure.Storage.Queue;
using System.Configuration;
using ContosoAdsCommon;
using System.Diagnostics;

namespace ContosoAdsWeb
{

    public class WebRole : RoleEntryPoint
    {

        public CloudStorageAccount storageAccount;
        public CloudTableClient tableClient;
        public CloudTable table;
        public CloudQueue msgQueue;

        public override bool OnStart()
        {
            // For information on handling configuration changes
            // see the MSDN topic at http://go.microsoft.com/fwlink/?LinkId=166357.


            Trace.TraceInformation("Web Role is running");

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

            var queueMsg = new CloudQueueMessage("Hello");
            msgQueue.AddMessage(queueMsg);

            return base.OnStart();

        }
    }
}
