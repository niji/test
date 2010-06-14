package org.libspark.gunyarapaint.ui.v1.net
{
    import flash.utils.ByteArray;
    
    import org.libspark.gunyarapaint.framework.net.IParameters;
    
    internal final class FakeParameters implements IParameters
    {
        public function serialize():ByteArray
        {
            var bytes:ByteArray = new ByteArray();
            bytes.writeBoolean(true);
            bytes.position = 0;
            return bytes;
        }
    }
}
