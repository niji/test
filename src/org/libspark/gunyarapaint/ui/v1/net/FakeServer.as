package org.libspark.gunyarapaint.ui.v1.net
{
    import flash.events.ProgressEvent;
    import flash.events.ServerSocketConnectEvent;
    import flash.net.ServerSocket;
    import flash.net.Socket;
    import flash.utils.ByteArray;

    public class FakeServer
    {
        public function FakeServer()
        {
            if (m_server.bound) {
                m_server.close();
                m_server = new ServerSocket();
            }
            var port:int = uint(Math.random() * 32768) + 8086;
            m_server.bind(port);
            m_server.addEventListener(ServerSocketConnectEvent.CONNECT, onConnect);
            m_server.listen();
        }
        
        public function get address():String
        {
            return m_server.localAddress;
        }
        
        public function get port():int
        {
            return m_server.localPort;
        }
        
        private function onConnect(event:ServerSocketConnectEvent):void
        {
            if (m_client != null) {
                m_client.close();
                m_client.removeEventListener(ProgressEvent.SOCKET_DATA, onData);
            }
            m_client = event.socket;
            m_client.addEventListener(ProgressEvent.SOCKET_DATA, onData);
        }
        
        private function onData(event:ProgressEvent):void
        {
            var buffer:ByteArray = new ByteArray();
            m_client.readBytes(buffer, 0, m_client.bytesAvailable);
        }
        
        private var m_server:ServerSocket = new ServerSocket();
        private var m_client:Socket;
    }
}
