using Microsoft.Data.SqlClient;
using NegocioWeb.Models;
using System.Collections.Generic;

namespace NegocioWeb.Data
{
    public class CategoriaRepository
    {
        private readonly ConexionDB _conexion;

        public CategoriaRepository(ConexionDB conexion)
        {
            _conexion = conexion;
        }

        public List<Categoria> ListarTodos()
        {
            var lista = new List<Categoria>();

            using (var connection = _conexion.ObtenerConexion())
            {
                string query = "SELECT Id, Nombre, Activo FROM Categorias ORDER BY Nombre ASC";
                using (var command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var categoria = new Categoria
                            {
                                Id = reader.GetInt32(0),
                                Nombre = reader.GetString(1),
                                Activo = reader.GetBoolean(2)
                            };
                            lista.Add(categoria);
                        }
                    }
                }
            }

            return lista;
        }
    }
}
