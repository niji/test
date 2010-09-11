package com.github.niji.gunyarapaint.ui.v1.net
{
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.Socket;
    import flash.net.URLVariables;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.flexunit.async.Async;
    import org.libspark.gunyarapaint.ui.v1.net.Parameters;

    public class ParametersTest
    {
        [Test(description="titleパラメータが無ければArgumentErrorを送出すること",
              expects="ArgumentError")]
        public function shouldInputTitle():void
        {
            var parameter:Parameters = new Parameters();
            parameter.serialize();
        }
        
        [Test(description="messageパラメータが無ければArgumentErrorを送出すること",
              expects="ArgumentError")]
        public function shouldInputMessage():void
        {
            var parameter:Parameters = new Parameters();
            parameter.title = "title";
            parameter.serialize();
        }
        
        [Ignore]
        [Test(async, timeout="3000",
              description="パラメータがserialize()によってByteArrayに変換されること")]
        public function shouldBeSerialized():void
        {
            var imageBytes:ByteArray = new ByteArray();
            var layerImageBytes:ByteArray = new ByteArray();
            var logBytes:ByteArray = new ByteArray();
            var parameter:Parameters = new Parameters();
            var server:FakeServer = new FakeServer();
            imageBytes.writeByte(0);
            layerImageBytes.writeByte(1);
            logBytes.writeByte(2);
            parameter.imageBytes = imageBytes;
            parameter.layerImageBytes = layerImageBytes;
            parameter.logBytes = logBytes;
            parameter.metadata = { "key": "value" };
            var params:Object = getParameters();
            for (var key:Object in params) {
                parameter[key] = params[key];
            }
            var socket:Socket = new Socket(server.address, server.port);
            server.addEventListener(Event.COMPLETE,
                Async.asyncHandler(this, onComplete, 3000));
            server.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            socket.writeBytes(parameter.serialize());
        }
        
        private function onComplete(event:Event, ignore:Object):void
        {
            var server:FakeServer = FakeServer(event.currentTarget);
            var result:Object = server.result;
            var info:ByteArray = ByteArray(result.IMAGE_INFO);
            var query:ByteArray = ByteArray(result.QUERY);
            var vars:URLVariables = new URLVariables();
            vars.decode(query.readUTFBytes(query.bytesAvailable));
            Assert.assertStrictlyEquals(0, ByteArray(result.IMAGE).readByte());
            Assert.assertStrictlyEquals(1, ByteArray(result.IMAGE_LAYERS).readByte());
            Assert.assertStrictlyEquals(2, ByteArray(result.IMAGE_LOG).readByte());
            Assert.assertStrictlyEquals('{"key":"value"}', info.readUTFBytes(info.bytesAvailable));
            var params:Object = getExpectedParameters();
            for (var key:Object in params) {
                Assert.assertEquals(params[key], vars[key]);
            }
        }
        
        private function getExpectedParameters():Object
        {
            var params:Object = getParameters();
            params["FROM"] = params["name"];
            params["MESSAGE"] = params["message"];
            params["log_count"] = params["logCount"];
            params["ref_oekaki_id"] = params["refererId"];
            params["watchlist"] = "t";
            delete params["name"];
            delete params["message"];
            delete params["logCount"];
            delete params["refererId"];
            delete params["shouldAddWatchList"];
            return params;
        }
        
        private function getParameters():Object
        {
            return {
                "cookie": "cookie",
                "logCount": 1,
                "magic": "magic",
                "message": "message",
                "name": "name",
                "refererId": 2,
                "shouldAddWatchList": true,
                "title": "title"
            };
        }
        
        private function onIOError(event:IOErrorEvent, ignore:Object):void
        {
            Assert.fail(event.text);
        }
    }
}
