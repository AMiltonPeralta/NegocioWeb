namespace NegocioWeb.Models;

public class Producto
{
    public int Id { get; set; }
    public string Nombre { get; set; } = "";
    
    
    public int MarcaId { get; set; }
    public Marca? Marca { get; set; }
    
    
    public int CategoriaId { get; set; }
    public Categoria? Categoria { get; set; }
    
    public int StockActual { get; set; }
    public int StockMinimo { get; set; }
    
    
    public decimal PorcentajeGanancia { get; set; }
    
    public bool Activo { get; set; } = true;
}
