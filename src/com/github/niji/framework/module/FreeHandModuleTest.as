package com.github.niji.framework.module
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.Recorder;
    import com.github.niji.framework.commands.ICommand;
    import com.github.niji.framework.modules.CanvasModuleContext;
    import com.github.niji.framework.modules.FreeHandModule;
    import com.github.niji.framework.modules.ICanvasModule;

    public final class FreeHandModuleTest
    {
        [Before]
        public function setup():void
        {
            m_bytes = new ByteArray();
            var recorder:Recorder = ModuleTestUtil.createRecorder(m_bytes);
            var context:CanvasModuleContext = new CanvasModuleContext(recorder);
            m_module = context.getModule(FreeHandModule.FREE_HAND);
        }
        
        [Test(description="FreeHandModuleであること")]
        public function shouldBeFreeHandModule():void
        {
            Assert.assertTrue(m_module is FreeHandModule);
            Assert.assertEquals(m_module.name, FreeHandModule.FREE_HAND);
        }
        
        [Test(description="移動せずに描画すると7つのコマンドが実行されること")]
        public function shouldExecuteSevenCommandsWithoutMoving():void
        {
            m_module.start(1, 1);
            m_module.stop(1, 1);
            ModuleTestUtil.assertCommands(7, m_bytes);
        }
        
        [Test(description="移動して描画すると3つのコマンドが実行されること")]
        public function shouldExecuteThreeCommandsWithMoving():void
        {
            m_module.start(1, 1);
            m_module.move(2, 2);
            m_module.stop(3, 3);
            ModuleTestUtil.assertCommands(3, m_bytes);
        }
        
        [Test(description="移動位置が保存されること")]
        public function shouldSaveCoordinates():void
        {
            ModuleTestUtil.assertLineSegment(m_module, true);
        }
        
        private var m_bytes:ByteArray;
        private var m_module:ICanvasModule;
    }
}
