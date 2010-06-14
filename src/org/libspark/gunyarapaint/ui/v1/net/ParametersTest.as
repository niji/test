package org.libspark.gunyarapaint.ui.v1.net
{
    import flash.utils.ByteArray;

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
        
        [Test(description="パラメータがserialize()によってByteArrayに変換されること")]
        public function shouldBeSerialized():void
        {
            var imageBytes:ByteArray = new ByteArray();
            var layerImageBytes:ByteArray = new ByteArray();
            var logBytes:ByteArray = new ByteArray();
            var parameter:Parameters = new Parameters();
            imageBytes.writeByte(0);
            layerImageBytes.writeByte(1);
            logBytes.writeByte(2);
            parameter.cookie = "cookie";
            parameter.imageBytes = imageBytes;
            parameter.layerImageBytes = layerImageBytes;
            parameter.logBytes = logBytes;
            parameter.logCount = 1;
            parameter.magic = "magic";
            parameter.message = "message";
            parameter.name = "name";
            parameter.refererId = 2;
            parameter.shouldAddWatchList = true;
            parameter.title = "title";
            parameter.metadata = { "key": "value" };
            trace(parameter.serialize());
        }
    }
}
