package org.libspark.gunyarapaint.ui.v1.net
{
    import flash.errors.IOError;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.ServerSocketConnectEvent;
    import flash.net.ServerSocket;
    import flash.net.Socket;
    import flash.utils.ByteArray;
    
    internal final class FakeServer extends EventDispatcher
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
        
        public function get result():Object
        {
            return m_result;
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
            parse(buffer);
        }
        
        private function parse(buffer:ByteArray):void
        {
            var name:ByteArray = new ByteArray();
            var data:ByteArray;
            var state:int = INIT;
            var pairs:Object = {};
            var size:int = 0;
            var index:int = 0;
            name.writeUTFBytes("QUERY");
            buffer.position = 0;
            while (buffer.bytesAvailable > 0) {
                var c:int = buffer.readByte();
                switch (state) {
                    case INIT: {
                        if (c == COLON)
                            state = SIZE;
                        else
                            state = UNKNOWN;
                        break;
                    }
                    case NAME: {
                        if (c != COLON) {
                            name.writeByte(c);
                        }
                        else if (c == COLON) {
                            size = 0;
                            state = SIZE;
                        }
                        else {
                            state = UNKNOWN;
                        }
                        break;
                    }
                    case SIZE: {
                        if (isDigit(c) && size <= MAX_DATA_SIZE) {
                            size = size * 10 + getDigit(c);
                        }
                        else if (c == EQUAL) {
                            data = new ByteArray();
                            index = 0;
                            state = DATA;
                        }
                        else {
                            state = UNKNOWN;
                        }
                        break;
                    }
                    case DATA: {
                        if (index < size) {
                            data.writeByte(c);
                            index++;
                        }
                        else {
                            setData(pairs, name, data);
                            name = new ByteArray();
                            state = NAME;
                        }
                        break;
                    }
                    case UNKNOWN: {
                        dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR,
                            false, false, "Illegal token state detected"));
                        break;
                    }
                }
            }
            setData(pairs, name, data);
            m_result = pairs;
            dispatchEvent(new Event(Event.COMPLETE));
        }
        
        private function isDigit(c:int):Boolean
        {
            return c >= ZERO && c <= NINE;
        }
        
        private function getDigit(c:int):int
        {
            return c - ZERO;
        }
        
        private function setData(pairs:Object, name:ByteArray, data:ByteArray):void
        {
            name.position = 0;
            data.position = 0;
            name.readUTFBytes(name.length);
            pairs[name] = data;
        }
        
        private static const MAX_DATA_SIZE:int = Math.pow(2, 24);
        private static const COLON:int = ':'.charCodeAt(0);
        private static const EQUAL:int = '='.charCodeAt(0);
        private static const ZERO:int = '0'.charCodeAt(0);
        private static const NINE:int = '9'.charCodeAt(0);
        private static const INIT:int = 1;
        private static const NAME:int = 2;
        private static const SIZE:int = 3;
        private static const DATA:int = 4;
        private static const UNKNOWN:int = -1;
        
        private var m_server:ServerSocket = new ServerSocket();
        private var m_client:Socket;
        private var m_result:Object;
    }
}
