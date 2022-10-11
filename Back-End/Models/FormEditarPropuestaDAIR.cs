using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Back_End.Models
{
    public class FormEditarPropuestaDAIR
    {
        public string Id { get; set; }
        [Required]
        public string SesionDAIRId { get; set; }
        [Required]
        public string Nombre { get; set; }
        [Required]
        public string Aprovado { get; set; }
        [Required]
        public string Link { get; set; }
    }
}