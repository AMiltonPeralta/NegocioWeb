var builder = WebApplication.CreateBuilder(args);


builder.Services.AddRazorPages();

// Configuración de acceso a datos y repositorios
builder.Services.AddSingleton<NegocioWeb.Data.ConexionDB>();
builder.Services.AddScoped<NegocioWeb.Data.CategoriaRepository>();
builder.Services.AddScoped<NegocioWeb.Data.MarcaRepository>();

var app = builder.Build();


if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseRouting();

app.UseAuthorization();

app.MapStaticAssets();
app.MapRazorPages()
   .WithStaticAssets();

app.Run();
