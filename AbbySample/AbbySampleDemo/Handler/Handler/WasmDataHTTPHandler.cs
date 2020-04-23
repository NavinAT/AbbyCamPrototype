using System;
using System.IO;
using System.Text;
using System.Web;

namespace DocumentWebCapture
{
    public class WasmDataHTTPHandler : IHttpHandler
    {
        /// <summary>
        /// You will need to configure this handler in the Web.config file of your 
        /// web and register it with IIS before being able to use it. For more information
        /// see the following link: https://go.microsoft.com/?linkid=8101007
        /// </summary>
        #region IHttpHandler Members

        public bool IsReusable
        {
            // Return false in case your Managed Handler cannot be reused for another request.
            // Usually this would be false in case you have some state information preserved per request.
            get { return true; }
        }

        public void ProcessRequest(HttpContext context)
        {
            HttpRequest req = context.Request;
            HttpResponse resp = context.Response;

            try
            {
                resp.ContentType = "text/plain";

                using(StreamReader sr = new StreamReader(Path.Combine(context.Request.MapPath("~"), "libs\\js\\wasm_engine_10.3.122217.data")))
                {
                    string strContent = sr.ReadToEnd();
                    resp.Write(strContent);
                }
            }
            catch(Exception e)
            {
                if(!context.IsCustomErrorEnabled)
                {
                    resp.Write("// FATAL ERROR: ");
                    resp.Write(e.Message);
                    resp.Write("\r\n");
                }
                else
                {
                    resp.SuppressContent = true;
                    resp.StatusCode = 500;
                    resp.StatusDescription = "Internal Error";
                }
                resp.AppendToLog("!!!-FATAL-ERROR-IN-SCRIPTCONFIG-!!!");
            }
        }

        #endregion
    }
}
