﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using System.Text;

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