package org.libspark.gunyarapaint.ui.v1
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.LayerBitmapCollection;
    import org.libspark.gunyarapaint.framework.UndoStack;

    public class ApplicationDataTest
    {
        [Test]
        public function shouldBeSymmetrical():void
        {
            var saverData:Object = {};
            var saver:ApplicationData = newApplicationData(saverData);
            var bytes:ByteArray = new ByteArray();
            var fromBytes:ByteArray = new ByteArray();
            var toBytes:ByteArray = new ByteArray();
            fromBytes.writeUTFBytes(VALUE);
            saver.save(bytes, fromBytes);
            bytes.position = 0;
            var loaderData:Object = {};
            var loader:ApplicationData = newApplicationData(loaderData);
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
        
        private function newApplicationData(data:Object):ApplicationData
        {
            var layers:LayerBitmapCollection = data.layers
                || new LayerBitmapCollection(1, 1);
            var undo:UndoStack = data.undo
                || new UndoStack(layers);
            var controllers:Vector.<IController> = data.controllers
                || new Vector.<IController>(1, true);
            var controller:FakeController = new FakeController();
            controllers[0] = controller;
            data.layers = layers;
            data.undo = undo;
            data.controllers = controllers;
            return new ApplicationData(layers, undo, controllers);
        }
        
        private static const VALUE:String = "This is a test.";
    }
}