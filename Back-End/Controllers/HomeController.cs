using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using System.Text;
using System.Web.UI.WebControls;
using System.Reflection;
using Back_End.Models;

namespace Back_End.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        [Route("Home")]
        [Route("Home/Index")]
        public ActionResult Index()
        {
            return View();
        }
        [Route("Home/SesionesAIR")]
        public ActionResult SesionesAIR()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("EXEC GetSesionesAIR", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            con.Close();
            da.Fill(dt);
            return View(dt);
        }
        [Route("Home/SesionesDAIR")]
        public ActionResult SesionesDAIR()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("EXEC GetSesionesDAIR", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            con.Close();
            da.Fill(dt);
            return View(dt);

        }
        
        [Route("Home/SesionAIR")]

        public ActionResult SesionAIR(string id)
        {
            SqlConnection conection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            conection.Open();
            SqlCommand cmd = new SqlCommand("EXEC ReadSesionAIR " + id, conection);
            SqlDataAdapter data = new SqlDataAdapter(cmd);
            DataTable datatable = new DataTable();
            conection.Close();
            data.Fill(datatable);
            return View(datatable);
        }

        [Route("Home/SesionDAIR")]

        public ActionResult SesionDAIR(string id)
        {
            SqlConnection conection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            conection.Open();
            SqlCommand cmd = new SqlCommand("EXEC ReadSesionDAIR " + id, conection);
            SqlDataAdapter data = new SqlDataAdapter(cmd);
            DataTable datatable = new DataTable();
            conection.Close();
            data.Fill(datatable);
            return View(datatable);
        }

        [Route("Home/CrearSesionAIR")]

        public ActionResult CrearSesionAIR()
        {
            SqlConnection conection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            conection.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.Periodo;", conection);
            SqlDataAdapter data = new SqlDataAdapter(cmd);
            DataTable datatable = new DataTable();
            conection.Close();
            data.Fill(datatable);
            List<SelectListItem> items = new List<SelectListItem>();
            foreach (DataRow row in datatable.Rows) {
                items.Add(new SelectListItem { Text = row["AnioInicio"].ToString()+" - "+ row["AnioFin"].ToString(), Value = row["Id"].ToString() });
            }
            ViewBag.Periodo = items;
            return View();
        }

        [HttpPost]
        public ActionResult GuardarNuevaSesionAIR(FormCrearSesionAIR model){
            if (ModelState.IsValid)
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("EXEC CreateSesionAIR "
                    + model.Periodo + ", '"
                    + model.Nombre + "', '"
                    + model.Fecha + "', '"
                    + model.TiempoInicial + "', '"
                    + model.TiempoFinal + "', '"
                    + model.Descripcion + "', '"
                    + model.PathArchivo + "'", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                con.Close();
                da.Fill(dt);
            }
            return RedirectToAction("SesionesAIR");
        }
        
        [Route("Home/Propuesta")]
        // https://stackoverflow.com/questions/11100981/asp-net-mvc-open-pdf-file-in-new-window
        public ActionResult Propuesta(string path)
        {
            return File(path, "application/pdf");
        }

        [Route("Home/EditarSesionAIR")]
        // https://stackoverflow.com/questions/11100981/asp-net-mvc-open-pdf-file-in-new-window
        public ActionResult EditarSesionAIR(string id)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("EXEC ReadSesionAIR " + id, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            con.Close();
            da.Fill(dt);
            ViewBag.NombreSesionAIR = dt.Rows[0]["Nombre"];
            ViewBag.FechaSesionAIR = dt.Rows[0]["Fecha"];
            return View(dt);
            //return File(path, "application/pdf");
        }

        public ActionResult BorrarSesionAIR(string id)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("EXEC DeleteSesionAIR " + id, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            con.Close();
            da.Fill(dt);
            return RedirectToAction("SesionesAIR");
        }
    }
}