using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace NegocioWeb.Pages
{
    public class LoginModel : PageModel
    {
        public void OnGet()
        {
        }

        public IActionResult OnPost()
        {
            // Simular inicio de sesión exitoso y redirigir al Dashboard
            return RedirectToPage("/Index");
        }
    }
}
