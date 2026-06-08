using Microsoft.Data.SqlClient;
using NegocioWeb.Models;
using System.Collections.Generic;

namespace NegocioWeb.Data
{
    public class MarcaRepository
    {
        private readonly ConexionDB _conexion;

        public MarcaRepository(ConexionDB conexion)
        {
            _conexion = conexion;
        }

        public List<Marca> ListarTodos()
        {
            var lista = new List<Marca>();

            using (var connection = _conexion.ObtenerConexion())
            {
                string query = "SELECT Id, Nombre, Activo FROM Marcas ORDER BY Nombre ASC";
                using (var command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var marca = new Marca
                            {
                                Id = reader.GetInt32(0),
                                Nombre = reader.GetString(1),
                                Activo = reader.GetBoolean(2)
                            };
                            lista.Add(marca);
                        }
                    }
                }
            }

            return lista;
        }
    }
}
