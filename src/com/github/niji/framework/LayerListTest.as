package com.github.niji.framework
{
    import flash.display.BitmapData;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.LayerList;

    public class LayerListTest
    {
        public const WIDTH:int = 123;
        public const HEIGHT:int = 321;
        
        [Test(description="画像の大きさを指定するとLayerListが作成されること")]
        public function shouldCreateLayerList():void
        {
            var lc:LayerList = newLayerList();
            Assert.assertStrictlyEquals(1, lc.count);
            Assert.assertStrictlyEquals(WIDTH, lc.width);
            Assert.assertStrictlyEquals(HEIGHT, lc.height);
            Assert.assertStrictlyEquals(WIDTH, lc.currentLayer.width);
            Assert.assertStrictlyEquals(HEIGHT, lc.currentLayer.height);
        }
        
        [Test(description="レイヤーが追加されること")]
        public function shouldAddLayer():void
        {
            var lc:LayerList = newLayerList();
            lc.add();
            Assert.assertStrictlyEquals(2, lc.count);
            Assert.assertStrictlyEquals("Layer1", lc.currentLayer.name);
        }
        
        [Test(description="レイヤーのコピーが作成されること")]
        public function shouldCopyLayer():void
        {
            var lc:LayerList = newLayerList();
            lc.copy();
            Assert.assertStrictlyEquals(2, lc.count);
            Assert.assertStrictlyEquals("Background's copy", lc.currentLayer.name);
        }
        
        [Test(description="レイヤーの交換が行われること")]
        public function shouldSwapLayers():void
        {
            var lc:LayerList = newLayerList();
            lc.add();
            lc.at(0).name = "foo";
            lc.at(1).name = "bar";
            lc.swap(0, 1);
            Assert.assertStrictlyEquals("bar", lc.at(0).name);
            Assert.assertStrictlyEquals("foo", lc.at(1).name);
        }
        
        [Test(description="レイヤーが統合されて、統合後のAlpha値が1.0になること")]
        public function shouldMergeLayers():void
        {
            var lc:LayerList = newLayerList();
            lc.add();
            lc.at(0).alpha = 0.5;
            lc.merge();
            Assert.assertStrictlyEquals(1, lc.count);
            Assert.assertStrictlyEquals(1.0, lc.at(0).alpha);
        }
        
        [Test(description="両方のレイヤーが可視でなければ統合が失敗すること",
              expects="com.github.niji.framework.errors.MergeLayersError")]
        public function shouldThrowMergeLayersErrorIfInvisibleLayerFound():void
        {
            var lc:LayerList = newLayerList();
            lc.add();
            lc.at(0).visible = false;
            lc.at(1).visible = false;
            lc.merge();
        }
        
        [Test(description="レイヤーがひとつしか無ければ失敗すること",
              expects="com.github.niji.framework.errors.MergeLayersError")]
        public function shouldThrowMergeLayersErrorIfOnlyOneLayerFound():void
        {
            var lc:LayerList = newLayerList();
            lc.merge();
        }
        
        [Test(description="規定数以上のレイヤーを作成すると例外を送出すること",
              expects="com.github.niji.framework.errors.AddLayerError")]
        public function shouldThrowAddLayerErrorIfCreateLayerOverMax():void
        {
            var lc:LayerList = newLayerList();
            var max:uint = LayerList.MAX;
            for (var i:uint = 0; i < max; i++) {
                lc.add();
            }
        }
        
        [Test(description="規定数以上のレイヤーをコピーすると例外を送出すること",
              expects="com.github.niji.framework.errors.AddLayerError")]
        public function shouldThrowAddLayerErrorIfCopyLayerOverMax():void
        {
            var lc:LayerList = newLayerList();
            var max:uint = LayerList.MAX ;
            for (var i:uint = 0; i < max; i++) {
                lc.copy();
            }
        }
        
        [Test(description="レイヤーが削除されること")]
        public function shouldRemoveLayer():void
        {
            var lc:LayerList = newLayerList();
            lc.add();
            lc.remove();
            Assert.assertStrictlyEquals(1, lc.count);
        }
        
        [Test(description="レイヤーが1枚しか無い状態で削除すると例外を送出すること",
              expects="com.github.niji.framework.errors.RemoveLayerError")]
        public function shouldThrowRemoveLayerErroIfRemoveBottomLayer():void
        {
            var lc:LayerList = newLayerList();
            lc.remove();
        }
        
        [Test(description="投稿時にレイヤー画像が一定のピクセル数以上だと例外を送出すること",
              expects="com.github.niji.framework.errors.TooManyLayersError")]
        public function shouldThrowTooManyLayersErorrIfLayerHaveMany():void
        {
            var lc:LayerList = new LayerList(12, 34);
            var bitmap:BitmapData = new BitmapData(lc.width, LayerList.MAX_PIXEL + 1);
            var metadata:Object = {};
            lc.save(bitmap, metadata);
        }
        
        private function newLayerList():LayerList
        {
            return new LayerList(WIDTH, HEIGHT);
        }
    }
}