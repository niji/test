package org.libspark.gunyarapaint.framework
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.FakePaintEngine;
    import org.libspark.gunyarapaint.framework.LayerBitmapCollection;
    import org.libspark.gunyarapaint.framework.Painter;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.UndoStack;
    import org.libspark.gunyarapaint.framework.ui.IController;
    import org.libspark.gunyarapaint.ui.v1.FakeController;

    public class MarshalTest
    {
        [Test]
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
