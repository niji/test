package com.github.niji.framework.module
{
    import com.github.niji.framework.Recorder;
    import com.github.niji.framework.commands.BeginFillCommand;
    import com.github.niji.framework.commands.CompositeCommand;
    import com.github.niji.framework.commands.DrawCircleCommand;
    import com.github.niji.framework.commands.EndFillCommand;
    import com.github.niji.framework.commands.LineToCommand;
    import com.github.niji.framework.commands.MoveToCommand;
    import com.github.niji.framework.commands.PenCommand;
    import com.github.niji.framework.modules.CanvasModuleContext;
    import com.github.niji.framework.modules.FreeHandModule;
    import com.github.niji.framework.modules.ICanvasModule;
    
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

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
            var expected:Vector.<Class> = Vector.<Class>([
                MoveToCommand,
                PenCommand,
                BeginFillCommand,
                DrawCircleCommand,
                EndFillCommand,
                PenCommand,
                CompositeCommand
            ]);
            m_module.start(1, 1);
            m_module.stop(1, 1);
            ModuleTestUtil.assertCommands(expected, m_bytes);
        }
        
        [Test(description="移動して描画すると3つのコマンドが実行されること")]
        public function shouldExecuteThreeCommandsWithMoving():void
        {
            var expected:Vector.<Class> = Vector.<Class>([
                MoveToCommand,
                LineToCommand,
                CompositeCommand
            ]);
            m_module.start(1, 1);
            m_module.move(2, 2);
            m_module.stop(3, 3);
            ModuleTestUtil.assertCommands(expected, m_bytes);
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
