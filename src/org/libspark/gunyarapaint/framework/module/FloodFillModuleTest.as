package org.libspark.gunyarapaint.framework.module
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.modules.CanvasModuleContext;
    import org.libspark.gunyarapaint.framework.modules.FloodFillModule;
    import org.libspark.gunyarapaint.framework.modules.ICanvasModule;

    public final class FloodFillModuleTest
    {
        [Before]
        public function setup():void
        {
            m_bytes = new ByteArray();
            var recorder:Recorder = ModuleTestUtil.createRecorder(m_bytes);
            var context:CanvasModuleContext = new CanvasModuleContext(recorder);
            m_module = context.getModule(FloodFillModule.FLOOD_FILL);
        }
        
        [Test(description="FloodFillModuleであること")]
        public function shouldBeFloodFillModule():void
        {
            Assert.assertTrue(m_module is FloodFillModule);
            Assert.assertEquals(m_module.name, FloodFillModule.FLOOD_FILL);
        }
        
        [Test(description="塗り潰しを実行すると2つのコマンドが実行されること")]
        public function shouldExecuteTwoCommands():void
        {
            m_module.start(1, 1);
            m_module.move(2, 2);
            m_module.stop(3, 3);
            ModuleTestUtil.assertCommands(2, m_bytes);
        }
        
        [Test(description="移動位置が保存されること")]
        public function shouldSaveCoordinates():void
        {
            ModuleTestUtil.assertLineSegment(m_module, false);
        }
        
        private var m_bytes:ByteArray;
        private var m_module:ICanvasModule;
    }
}
