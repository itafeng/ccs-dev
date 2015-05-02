using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
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
using System.Text;


namespace ContosoAdsWeb.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = GetSystemInfo(); 

            return View();
        }

        public ActionResult System()
        {
            ViewBag.Message = GetSystemInfo();            

            return View();
        }

        public string GetSystemInfo()
        {
            StringBuilder rows = new StringBuilder();

            try
            {
                // Retrieve storage account
                CloudStorageAccount storageAccount = CloudStorageAccount.Parse(CloudConfigurationManager.GetSetting("StorageConnectionString"));

                //Create a table client
                CloudTableClient tableClient = storageAccount.CreateCloudTableClient();

                // Create table
                CloudTable table = tableClient.GetTableReference("system");

                // Construct the query operation for all customer entities where PartitionKey="Tom".
                TableQuery<CustomerEntity> query = new TableQuery<CustomerEntity>().Where(TableQuery.GenerateFilterCondition("PartitionKey", QueryComparisons.Equal, "Tom"));

                foreach (CustomerEntity entity in table.ExecuteQuery(query))
                {
                    rows.AppendFormat(tableRowFormatter, entity.Name, entity.Value);
                    Trace.TraceInformation("{0}, {1}\t{2}\t{3}", entity.PartitionKey, entity.RowKey, entity.Name, entity.Value);
                }
            }
            catch (Exception e)
            {
                Trace.TraceError("Exception in Web Role OnStart Function: {0}", e.Message);
            }

            return string.Format(tableHeader + rows + tableFooter, "Name", "Value");
        }


        public readonly string tableHeader = @"
          <HTML>
            <TABLE>
              <TR style='background-color: rgb(197,217,241);'>
                <TH>{0}</TH>
                <TH>{1}</TH>
              </TR>
";

        public readonly string tableRowFormatter = @"
              <TR>
                <TD valign=top nowrap>{0}</TD>
                <TD valign=top nowrap >{1}</TD>
              </TR>
";
        public readonly string tableFooter = @"
           </TABLE>
          </HTML>    
";


    }
}