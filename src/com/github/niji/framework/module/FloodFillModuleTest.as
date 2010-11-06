package com.github.niji.framework.module
{
    import com.github.niji.framework.Recorder;
    import com.github.niji.framework.commands.FloodFillCommand;
    import com.github.niji.framework.commands.MoveToCommand;
    import com.github.niji.framework.modules.CanvasModuleContext;
    import com.github.niji.framework.modules.FloodFillModule;
    import com.github.niji.framework.modules.ICanvasModule;
    
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

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
            var expected:Vector.<Class> = Vector.<Class>([
                MoveToCommand,
                FloodFillCommand
            ]);
            m_module.start(1, 1);
            m_module.move(2, 2);
            m_module.stop(3, 3);
            ModuleTestUtil.assertCommands(expected, m_bytes);
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
