package com.github.niji.framework
{
    import com.github.niji.framework.FakePaintEngine;
    import com.github.niji.framework.Marshal;
    import com.github.niji.framework.Recorder;
    import com.github.niji.framework.ui.IController;
    import com.github.niji.gunyarapaint.ui.v1.FakeController;
    
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public class MarshalTest
    {
        [Test(description="保存したあと読み込んで値が復元されること")]
        public function shouldBeSymmetrical():void
        {
            var marshalData:Object = {};
            var marshal:Marshal = newMarshal(marshalData);
            var bytes:ByteArray = new ByteArray();
            var fromBytes:ByteArray = new ByteArray();
            var toBytes:ByteArray = new ByteArray();
            fromBytes.writeUTFBytes(VALUE);
            marshal.save(bytes, fromBytes);
            bytes.position = 0;
            var loaderData:Object = {};
            var loader:Marshal = newMarshal(loaderData);
            var controller:FakeController = loaderData.controllers[0];
            loader.load(bytes, toBytes);
            // should set the end of log after ApplicationData#load
            Assert.assertEquals(0, toBytes.bytesAvailable);
            Assert.assertEquals(VALUE.length, toBytes.position);
            // reset result's position
            toBytes.position = 0;
            Assert.assertEquals(VALUE, toBytes.readUTFBytes(VALUE.length));
            Assert.assertEquals(controller.name, controller.value);
        }
        
        [Test(description = "指定されたバージョンよりも大きいバージョンを読み込むと例外を送出すること",
              expects="com.github.niji.framework.errors.MarshalVersionError")]
        public function shouldThrowMarshalVersionError():void
        {
            var marshalData:Object = {};
            var marshal:Marshal = newMarshal(marshalData);
            var bytes:ByteArray = new ByteArray();
            var toBytes:ByteArray = new ByteArray();
            bytes.writeByte(Marshal.VERSION + 1);
            bytes.deflate();
            marshal.load(bytes, toBytes);
        }
        
        [Test(description = "異なる大きさの画像のログを読み込むと例外を送出すること",
              expects="com.github.niji.framework.errors.MarshalRectError")]
        public function shouldThrowMarshalRectError():void
        {
            var marshalData:Object = {};
            var marshal:Marshal = newMarshal(marshalData);
            var bytes:ByteArray = new ByteArray();
            var toBytes:ByteArray = new ByteArray();
            bytes.writeByte(Marshal.VERSION);
            bytes.writeObject(new ByteArray());
            bytes.writeObject(new Rectangle(0, 0, int.MAX_VALUE, int.MAX_VALUE));
            bytes.writeObject(new Vector.<uint>());
            bytes.writeObject({}); // metadata
            bytes.writeObject({}); // undodata
            bytes.writeObject({}); // controller
            bytes.deflate();
            marshal.load(bytes, toBytes);
        }
        
        private function newMarshal(data:Object):Marshal
        {
            var recorder:Recorder = Recorder.create(new ByteArray(), 1, 1, 1);
            var controllers:Vector.<IController> = data.controllers
                || new Vector.<IController>(1, true);
            var controller:FakeController = new FakeController();
            controllers[0] = controller;
            data.painter = recorder;
            data.controllers = controllers;
            return new Marshal(recorder, controllers);
        }
        
        private static const VALUE:String = "This is a test.";
    }
}
