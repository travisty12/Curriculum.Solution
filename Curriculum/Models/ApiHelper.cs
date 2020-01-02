using System.Threading.Tasks;
using System.Collections.Generic;
using System;
using RestSharp;

namespace Curriculum.Models
{
  class ApiHelper
  {

    public static RestClient client = new RestClient("http://localhost:9000/api");
    public static Dictionary<string, Method> methods = new Dictionary<string, Method>()
    {
      { "post", Method.POST },
      { "put", Method.PUT },
      { "delete", Method.DELETE }
    };

    public static async Task<string> Get(string route)
    {
      RestRequest request = new RestRequest($"{route}", Method.GET);
      var response = await client.ExecuteTaskAsync(request);
      return response.Content;
    }
    public static async Task Send(string route, string obj, string method)
    {
      RestRequest request = new RestRequest($"{route}", methods[method]);
      request.RequestFormat = DataFormat.Json;
      request.AddHeader("Content-Type", "application/json");
      request.AddJsonBody(obj);
      var response = await client.ExecuteTaskAsync(request);
    }
  }
}