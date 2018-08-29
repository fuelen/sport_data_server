defmodule SportDataServerWeb.HealthCheckRouter do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "ok")
  end
end
