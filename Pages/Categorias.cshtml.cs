using Microsoft.AspNetCore.Mvc.RazorPages;
using NegocioWeb.Data;
using NegocioWeb.Models;
using System.Collections.Generic;

namespace NegocioWeb.Pages
{
    public class CategoriasModel : PageModel
    {
        private readonly CategoriaRepository _repository;

        public List<Categoria> Categorias { get; set; } = new List<Categoria>();

        public CategoriasModel(CategoriaRepository repository)
        {
            _repository = repository;
        }

        public void OnGet()
        {
            Categorias = _repository.ListarTodos();
        }
    }
}
