package com.github.niji.gunyarapaint.ui.v1.net
{
    import com.github.niji.framework.net.IParameters;
    
    import flash.utils.ByteArray;
    
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
