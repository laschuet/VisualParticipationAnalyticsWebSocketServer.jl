"""
    start(port::Integer)
"""
function start(port::Integer)
    @async HTTP.listen(HTTP.Sockets.localhost, port) do http
        if HTTP.WebSockets.is_upgrade(http.message)
            HTTP.WebSockets.upgrade(http) do ws
                while !eof(ws);
                    msg = String(readavailable(ws))
                    println(msg)
                    write(ws, msg)
                end
            end
        end
    end
    println("WebSocket server is running at http://localhost:$port")
end
