using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Back_End
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional });
            routes.MapRoute(
                name: "SesionesAIR",
                url: "{controller}/SesionesAIR",
                defaults: new { controller = "Home", action = "SesionesAIR" }
            );
            routes.MapRoute(
                name: "SesionesDAIR",
                url: "{controller}/SesionesDAIR",
                defaults: new { controller = "Home" }
            );
            routes.MapRoute(
                name: "Propuesta",
                url: "{controller}/Propuesta",
                defaults: new {controller = "Home"}
            );
        }
    }
}
