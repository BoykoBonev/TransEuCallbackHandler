using Microsoft.AspNetCore.Mvc;
using System.Collections.Concurrent;

namespace TransEuCallbackHandler.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CallbacksController : ControllerBase
    {
        // In-memory store for events
        private static readonly ConcurrentBag<object> Events = new();

        // Endpoint to receive callbacks
        [HttpPost("receive")]
        public IActionResult ReceiveCallback([FromBody] object callbackData)
        {
            Events.Add(callbackData);
            return Ok(new { Message = "Event received successfully" });
        }

        // Endpoint to view stored events
        [HttpGet("events")]
        public IActionResult GetEvents()
        {
            return Ok(Events);
        }
    }
}
