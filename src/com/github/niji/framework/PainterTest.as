package com.github.niji.framework
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.geom.Point;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.BitmapLayer;
    import com.github.niji.framework.PaintEngine;
    import com.github.niji.framework.Painter;
    import com.github.niji.framework.UndoStack;
    import com.github.niji.framework.Version;

    public class PainterTest
    {
        [Test(description="moveToは座標を移動すること")]
        public function shouldMoveCoordinates():void
        {
            var x:int = 42;
            var y:int = 124;
            var painter:Painter = newPainter();
            painter.moveTo(x, y);
            Assert.assertStrictlyEquals(x, FakePaintEngine.point.x);
            Assert.assertStrictlyEquals(y, FakePaintEngine.point.y);
        }
        
        [Test(description="drawCircleは半径を元に円を描写すること")]
        public function shouldDrawCircleByRadius():void
        {
            var radius:Number = 3.14;
            var painter:Painter = newPainter();
            painter.drawCircle(radius);
            Assert.assertStrictlyEquals(radius, FakePaintEngine.radius);
        }
        
        [Test(description="drawRectは長方形の大きさに従って描写すること")]
        public function shouldDrawRectByRectangle():void
        {
            var x:int = 42;
            var y:int = 124;
            var width:int = 256;
            var height:int = 512;
            var painter:Painter = newPainter();
            painter.drawRect(x, y, width, height);
            Assert.assertStrictlyEquals(x, FakePaintEngine.rectangle.x);
            Assert.assertStrictlyEquals(y, FakePaintEngine.rectangle.y);
            Assert.assertStrictlyEquals(width, FakePaintEngine.rectangle.width);
            Assert.assertStrictlyEquals(height, FakePaintEngine.rectangle.height);
        }
        
        [Test(description="drawEllipseは長方形の大きさに従って描写すること")]
        public function shouldDrawEllipseByRectangle():void
        {
            var x:int = 512;
            var y:int = 256;
            var width:int = 128;
            var height:int = 64;
            var painter:Painter = newPainter();
            painter.drawEllipse(x, y, width, height);
            Assert.assertStrictlyEquals(x, FakePaintEngine.rectangle.x);
            Assert.assertStrictlyEquals(y, FakePaintEngine.rectangle.y);
            Assert.assertStrictlyEquals(width, FakePaintEngine.rectangle.width);
            Assert.assertStrictlyEquals(height, FakePaintEngine.rectangle.height);
        }
        
        [Test(description="floodFillは色と不透明度によって描写すること")]
        public function shouldFloodFillByColorAndAlpha():void
        {
            var color:uint = uint.MAX_VALUE;
            var alpha:Number = 0.5;
            var painter:Painter = newPainter();
            painter.beginFill(color, alpha);
            painter.endFill();
            Assert.assertStrictlyEquals(color, FakePaintEngine.color);
            Assert.assertStrictlyEquals(alpha, FakePaintEngine.alpha);
            Assert.assertTrue(FakePaintEngine.filled);
        }
        
        [Test(description="startDrawingによって描写レイヤーの追加、stopDrawingで削除が行われること")]
        public function shouldStartDrawingAddsDrawingLayerAndStopDrawingRemovesIt():void
        {
            var child:DisplayObject;
            var painter:Painter = newPainter();
            // 描写セッションの開始されると一時 Sprite が作成される
            // その為、上に現在のレイヤーが、下に描写バッファが入る
            painter.startDrawing();
            child = painter.layers.view.getChildAt(0);
            Assert.assertTrue(child is Sprite);
            var sprite:Sprite = Sprite(child);
            Assert.assertTrue(sprite.getChildAt(0) is Bitmap);
            Assert.assertTrue(sprite.getChildAt(1) is Shape);
            // 描写セッションが終了すると一時 Sprite が削除され、現在のレイヤーに戻される
            painter.stopDrawing();
            child = painter.layers.view.getChildAt(0);
            Assert.assertTrue(child is Bitmap);
        }
        
        [Test(description="saveによってレイヤーの情報の保存、loadでそれを復元すること")]
        public function shouldRestoreLayersAfterSaving():void
        {
            var metadata:Object = {};
            var painter:Painter = newPainterForSave();
            var src:BitmapLayer = BitmapLayer(painter.layers.at(2));
            var layers:BitmapData = painter.layers.newLayerBitmapData;
            painter.layers.save(layers, metadata);
            Assert.assertEquals(metadata.width, painter.width);
            Assert.assertEquals(metadata.height, painter.height);
            Assert.assertEquals(3, metadata.layer_infos.length);
            var painter2:Painter = new Painter(3, 1, Version.LOG_VERSION, new FakePaintEngine());
            painter2.layers.load(layers, metadata);
            var count:uint = painter2.layers.count;
            for (var i:uint = 0; i < count; i++) {
                Assert.assertEquals(i, painter2.layers.at(i).index);
            }
            Assert.assertEquals(3, painter2.layers.count);
            var dst:BitmapLayer = BitmapLayer(painter2.layers.at(2));
            Assert.assertEquals(dst.alpha, src.alpha);
            Assert.assertEquals(dst.blendMode, src.blendMode);
            Assert.assertTrue(dst.locked);
            Assert.assertEquals(dst.name, src.name);
            Assert.assertFalse(dst.visible);
            // BitmapLayerCollection#compositeAll is the internal method.
            painter2.layers.compositeAll();
            Assert.assertEquals(0xff0000, painter2.getPixel(0, 0));
            Assert.assertEquals(0x00ff00, painter2.getPixel(1, 0));
            // layer(test012) is NOT visible
            Assert.assertEquals(0xffffff, painter2.getPixel(2, 0));
            // reset alpha, blend mode and visibility
            dst.blendMode = BlendMode.NORMAL;
            dst.alpha = 1;
            dst.visible = true;
            painter2.layers.compositeAll();
            var i2:Vector.<uint> = painter2.layers.composited.getVector(painter2.layers.composited.rect);
            // layer(test012) is now visible
            Assert.assertEquals(0x0000ff, painter2.getPixel(2, 0));
        }
        
        [Test(description="PaintEngineV1の座標補正が正しく行われていること")]
        public function shouldCorrectCoordinatesWithPaintEngineV1():void
        {
            var engine:PaintEngine = Painter.createPaintEngine(1);
            assertCorrectedPoint(engine, 1, 1, 1.23, 1.23);
            assertCorrectedPoint(engine, -1, -1, -1.23, -1.23);
            assertCorrectedPoint(engine, 2, 2, 1.98, 1.98);
            assertCorrectedPoint(engine, -2, -2, -1.98, -1.98);
        }
		
		[Test(description="PaintEngineV2の座標補正が正しく行われていること")]
        public function shouldCorrectCoordinatesWithPaintEngineV2():void
        {
            var engine:PaintEngine = Painter.createPaintEngine(11);
            engine.pen.thickness = 8;
            assertCorrectedPoint(engine, 1, 1, 1.23, 1.23);
            assertCorrectedPoint(engine, -2, -2, -1.23, -1.23);
            assertCorrectedPoint(engine, 1, 1, 1.98, 1.98);
            assertCorrectedPoint(engine, -2, -2, -1.98, -1.98);
            engine.pen.thickness = 15;
            assertCorrectedPoint(engine, 1.5, 1.5, 1.23, 1.23);
            assertCorrectedPoint(engine, -1.5, -1.5, -1.23, -1.23);
            assertCorrectedPoint(engine, 1.5, 1.5, 1.98, 1.98);
            assertCorrectedPoint(engine, -1.5, -1.5, -1.98, -1.98);
        }
        
        [Test(description="enableUndoLayerが設定されていればpushUndoIfでもUndoStackが積まれること")]
        public function shouldPushUndoIfEnableUndoLayerIsTrue():void
        {
            var painter:Painter = newPainter();
            var undo:UndoStack = new UndoStack(painter.layers);
            painter.setUndoStack(undo);
            painter.pushUndoIfNeed();
            Assert.assertEquals(0, undo.undoCount);
            painter.enableUndoLayer = true;
            painter.pushUndoIfNeed();
            Assert.assertEquals(1, undo.undoCount);
        }
        
        [Test(description="versionが21以上であればpushUndoIfでもUndoStackが積まれること")]
        public function shouldPushUndoIfVersionIsGreaterThan21():void
        {
            var painter:Painter = newPainter();
            var undo:UndoStack = new UndoStack(painter.layers);
            painter.setUndoStack(undo);
            painter.pushUndoIfNeed();
            Assert.assertEquals(0, undo.undoCount);
            painter.setVersion(21);
            painter.pushUndoIfNeed();
            Assert.assertEquals(1, undo.undoCount);
        }
        
        private function newPainter():Painter
        {
            return new Painter(1, 1, Version.LOG_VERSION, new FakePaintEngine());
        }
        
        private function assertCorrectedPoint(engine:PaintEngine,
                                              expectedX:Number,
                                              expectedY:Number,
                                              inputX:Number,
                                              inputY:Number):void
        {
            input.x = inputX;
            input.y = inputY;
            engine.correctCoordinate(input);
            Assert.assertEquals(expectedX, input.x);
            Assert.assertEquals(expectedY, input.x);
        }
        
        private function newPainterForSave():Painter
        {
            var painter:Painter = new Painter(3, 1, Version.LOG_VERSION, new FakePaintEngine());
            painter.pen.color = 0xff0000;
            painter.setPixel(0, 0);
            painter.layers.add();
            painter.pen.color = 0x00ff00;
            painter.setPixel(1, 0);
            painter.layers.add();
            painter.pen.color = 0x0000ff;
            painter.setPixel(2, 0);
            var src:BitmapLayer = BitmapLayer(painter.layers.at(2));
            src.alpha = 0.5;
            src.blendMode = BlendMode.ADD;
            src.locked = true;
            src.name = "test012";
            src.visible = false;
            return painter;
        }
        
        private static var input:Point = new Point();
    }
}