using Microsoft.AspNetCore.Mvc.RazorPages;
using NegocioWeb.Data;
using NegocioWeb.Models;
using System.Collections.Generic;

namespace NegocioWeb.Pages
{
    public class MarcasModel : PageModel
    {
        private readonly MarcaRepository _repository;

        public List<Marca> Marcas { get; set; } = new List<Marca>();

        public MarcasModel(MarcaRepository repository)
        {
            _repository = repository;
        }

        public void OnGet()
        {
            Marcas = _repository.ListarTodos();
        }
    }
}
