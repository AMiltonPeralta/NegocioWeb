using Microsoft.Data.SqlClient;

namespace NegocioWeb.Data
{
    public class ConexionDB
    {
        private readonly string _connectionString;

        public ConexionDB(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection") 
                ?? "Server=(localdb)\\MSSQLLocalDB;Database=NegocioWebDB;Trusted_Connection=True;";
        }

        public SqlConnection ObtenerConexion()
        {
            return new SqlConnection(_connectionString);
        }
    }
}
