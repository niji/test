package org.libspark.gunyarapaint.framework.module
{
    import flash.display.BlendMode;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.CanvasModuleContext;
    import org.libspark.gunyarapaint.framework.modules.ICanvasModule;
    import org.libspark.gunyarapaint.framework.modules.TransparentLineModule;

    public final class TransparentLineTest
    {
        [Before]
        public function setup():void
        {
            m_bytes = new ByteArray();
            m_recorder = ModuleTestUtil.createRecorder(m_bytes);
            var context:CanvasModuleContext = new CanvasModuleContext(m_recorder);
            m_module = context.getModule(TransparentLineModule.TRANSPARENT_LINE);
        }
        
        [Test]
        public function TransparentLineModuleであること():void
        {
            Assert.assertTrue(m_module is TransparentLineModule);
            Assert.assertEquals(m_module.name, TransparentLineModule.TRANSPARENT_LINE);
        }
        
        [Test]
        public function 移動せずに描画すると何も起こならないがブレンドモードは復帰されること():void
        {
            m_recorder.pen.blendMode = BlendMode.ADD;
            m_module.start(1, 1);
            m_module.stop(1, 1);
            ModuleTestUtil.countCommands(0, m_bytes);
            Assert.assertStrictlyEquals(BlendMode.ADD, m_recorder.pen.blendMode);
        }
        
        [Test]
        public function 移動して描画すると5つのコマンドが実行された上でブレンドモードが復帰されること():void
        {
            m_recorder.pen.blendMode = BlendMode.DARKEN;
            m_module.start(1, 1);
            m_module.move(2, 2);
            m_module.stop(3, 3);
            ModuleTestUtil.countCommands(5, m_bytes);
            Assert.assertStrictlyEquals(BlendMode.DARKEN, m_recorder.pen.blendMode);
        }
        
        [Test]
        public function 移動位置が保存されること():void
        {
            ModuleTestUtil.getLineSegment(m_module, true);
        }
        
        private var m_bytes:ByteArray;
        private var m_recorder:Recorder;
        private var m_module:ICanvasModule;
    }
}
