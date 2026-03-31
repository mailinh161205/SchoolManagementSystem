using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace SchoolManagementSystem.Models
{
    public class CommonFn
    {
        public class Commonfnx
        {
            private string conStr = ConfigurationManager.ConnectionStrings["SchoolCS"].ConnectionString;

            public void Query(string query)
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(conStr))
                    {
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("SQL Error: " + ex.Message);
                }
            }
            public DataTable Fetch(string query)
            {
                DataTable dt = new DataTable();

                try
                {
                    using (SqlConnection con = new SqlConnection(conStr))
                    {
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                            {
                                sda.Fill(dt);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("SQL Fetch Error: " + ex.Message);
                }

                return dt;
            }
            public DataTable Fetch(string query, params SqlParameter[] parameters)
            {
                DataTable dt = new DataTable();

                try
                {
                    using (SqlConnection con = new SqlConnection(conStr))
                    {
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            if (parameters != null)
                            {
                                cmd.Parameters.AddRange(parameters);
                            }

                            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                            {
                                sda.Fill(dt);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("SQL Fetch Error: " + ex.Message);
                }

                return dt;
            }

            public void Query(string query, params SqlParameter[] parameters)
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(conStr))
                    {
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            if (parameters != null)
                            {
                                cmd.Parameters.AddRange(parameters);
                            }

                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("SQL Error: " + ex.Message);
                }
            }
        }
    }
}