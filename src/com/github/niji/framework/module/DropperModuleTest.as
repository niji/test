package com.github.niji.framework.module
{
    import com.github.niji.framework.Recorder;
    import com.github.niji.framework.commands.PenCommand;
    import com.github.niji.framework.modules.CanvasModuleContext;
    import com.github.niji.framework.modules.DropperModule;
    import com.github.niji.framework.modules.ICanvasModule;
    
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public final class DropperModuleTest
    {
        [Before]
        public function setup():void
        {
            m_bytes = new ByteArray();
            var recorder:Recorder = ModuleTestUtil.createRecorder(m_bytes);
            var context:CanvasModuleContext = new CanvasModuleContext(recorder);
            m_module = context.getModule(DropperModule.DROPPER);
        }
        
        [Test(description="DropperModuleであること")]
        public function shouldBeDropperModule():void
        {
            Assert.assertTrue(m_module is DropperModule);
            Assert.assertEquals(m_module.name, DropperModule.DROPPER);
        }
        
        [Test(description="スポイトを実行すると1つのコマンドが実行されること")]
        public function shouldExecuteOneCommand():void
        {
            var expected:Vector.<Class> = Vector.<Class>([ PenCommand ]);
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
