package com.github.niji.framework
{
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.BitmapLayer;
    import org.libspark.gunyarapaint.framework.ILayer;

    // BitmapLayer#compositeTo is tested in PainterTest#レイヤー情報の保存と復帰
    public class BitmapLayerTest
    {
        [Test(description="レイヤーが作成されること")]
        public function shouldCreateLayer():void
        {
            var layer:BitmapLayer = new BitmapLayer(newSmallBitmapData());
            Assert.assertTrue(layer is BitmapLayer);
        }
        
        [Test(description="レイヤーがクローンされること")]
        public function shouldCloneLayer():void
        {
            var layer:BitmapLayer = newLayerToClone();
            var newLayer:BitmapLayer = BitmapLayer(layer.clone());
            assertLayerMetadata(layer, newLayer);
            Assert.assertStrictlyEquals(layer.index, newLayer.index);
            // BitmapLayer#bitmapData is the internal method
            Assert.assertEquals(0, newLayer.bitmapData.compare(layer.bitmapData));
        }
        
        [Test(description="塗りつぶしが出来ること")]
        public function shouldBeAbleToFloodFill():void
        {
            var bmd:BitmapData = newBigBitmapData();
            var layer:BitmapLayer = new BitmapLayer(bmd);
            layer.floodFill(5, 5, 0);
            Assert.assertStrictlyEquals(0, layer.bitmapData.getPixel32(5, 5));
            Assert.assertStrictlyEquals(0, layer.bitmapData.getPixel32(0, 0));
        }
        
        [Test(description="ドット打ちが出来ること")]
        public function shouldBeAbleToSetPixel():void
        {
            var bmd:BitmapData = newBigBitmapData();
            var layer:BitmapLayer = new BitmapLayer(bmd);
            layer.setPixel(5, 5, 0);
            Assert.assertStrictlyEquals(0, layer.bitmapData.getPixel32(5, 5));
            Assert.assertStrictlyEquals(uint.MAX_VALUE, layer.bitmapData.getPixel32(0, 0));
        }
        
        [Test(description="JSONのシリアライズが出来ること")]
        public function shouldSerializeFromAndToJSON():void
        {
            var layer:BitmapLayer = newLayerToClone();
            var newLayer:BitmapLayer = new BitmapLayer(newBigBitmapData());
            newLayer.fromJSON(layer.toJSON());
            assertLayerMetadata(layer, newLayer);
            Assert.assertStrictlyEquals(layer.locked, newLayer.locked);
        }
        
        private function assertLayerMetadata(layer:ILayer, newLayer:ILayer):void
        {
            Assert.assertStrictlyEquals(layer.alpha, newLayer.alpha);
            Assert.assertStrictlyEquals(layer.blendMode, newLayer.blendMode);
            Assert.assertStrictlyEquals(layer.name, newLayer.name);
            Assert.assertStrictlyEquals(layer.visible, newLayer.visible);
        }
        
        private function newLayerToClone():BitmapLayer
        {
            var layer:BitmapLayer = new BitmapLayer(newBigBitmapData());
            layer.alpha = 0.42;
            layer.blendMode = BlendMode.MULTIPLY;
            layer.locked = true;
            layer.name = "test";
            layer.visible = false;
            layer.setIndex(42);
            return layer;
        }
        
        private function newSmallBitmapData():BitmapData
        {
            return new BitmapData(1, 1);
        }
        
        private function newBigBitmapData():BitmapData
        {
            return new BitmapData(10, 10);
        }
    }
}