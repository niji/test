package org.libspark.gunyarapaint.framework.module
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Pen;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.CanvasModuleContext;
    import org.libspark.gunyarapaint.framework.modules.ICanvasModule;
    import org.libspark.gunyarapaint.framework.modules.TransparentFloodFill;

    public final class TransparentFloodFillTest
    {
        [Before]
        public function setup():void
        {
            m_bytes = new ByteArray();
            m_recorder = ModuleTestUtil.createRecorder(m_bytes);
            var context:CanvasModuleContext = new CanvasModuleContext(m_recorder);
            m_module = context.getModule(TransparentFloodFill.TRANSPARENT_FLOOD_FILL);
        }
        
        [Test(description="TransparentFloodFillModuleであること")]
        public function shouldBeTransparentFloodFillModule():void
        {
            Assert.assertTrue(m_module is TransparentFloodFill);
            Assert.assertEquals(m_module.name, TransparentFloodFill.TRANSPARENT_FLOOD_FILL);
        }
        
        [Test(description="透明塗りつぶしを実行すると6つのコマンドが実行された上で色情報が復帰されること")]
        public function shouldExecuteSixCommandsAndRestoreColorAndAlpha():void
        {
            var pen:Pen = m_recorder.pen;
            pen.alpha = 0.5;
            pen.color = 0x123456;
            m_module.start(1, 1);
            m_module.move(2, 2);
            m_module.stop(3, 3);
            ModuleTestUtil.assertCommands(6, m_bytes);
            Assert.assertStrictlyEquals(0.5, pen.alpha);
            Assert.assertStrictlyEquals(0x123456, pen.color);
        }
        
        [Test(description="途中で中断したとしても色情報が復帰されること")]
        public function shouldRestoreColorAndAlphaIfInterrupted():void
        {
            var pen:Pen = m_recorder.pen;
            pen.alpha = 0.5;
            pen.color = 0x123456;
            m_module.start(1, 1);
            m_module.interrupt(2, 2);
            ModuleTestUtil.assertCommands(6, m_bytes);
            Assert.assertStrictlyEquals(0.5, pen.alpha);
            Assert.assertStrictlyEquals(0x123456, pen.color);
        }
        
        [Test(description="移動位置が保存されること")]
        public function shouldSaveCoordinates():void
        {
            ModuleTestUtil.assertLineSegment(m_module, false);
        }
        
        private var m_bytes:ByteArray;
        private var m_recorder:Recorder;
        private var m_module:ICanvasModule;
    }
}
