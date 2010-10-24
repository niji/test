package com.github.niji.framework.module
{
    import com.github.niji.framework.Recorder;
    import com.github.niji.framework.commands.CompositeCommand;
    import com.github.niji.framework.commands.DrawRectangleCommand;
    import com.github.niji.framework.commands.ICommand;
    import com.github.niji.framework.commands.MoveToCommand;
    import com.github.niji.framework.modules.CanvasModuleContext;
    import com.github.niji.framework.modules.ICanvasModule;
    import com.github.niji.framework.modules.RectangleModule;
    
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public final class RectangleModuleTest
    {
        [Before]
        public function setup():void
        {
            m_bytes = new ByteArray();
            var recorder:Recorder = ModuleTestUtil.createRecorder(m_bytes);
            var context:CanvasModuleContext = new CanvasModuleContext(recorder);
            m_module = context.getModule(RectangleModule.RECTANGLE);
        }
        
        [Test(description="RectangleModuleであること")]
        public function shouldBeRectModule():void
        {
            Assert.assertTrue(m_module is RectangleModule);
            Assert.assertEquals(m_module.name, RectangleModule.RECTANGLE);
        }
        
        [Test(description="移動せずに描画すると何も起こらないこと")]
        public function shouldDoNothingWithoutMoving():void
        {
            m_module.start(1, 1);
            m_module.stop(1, 1);
            ModuleTestUtil.assertCommands(Vector.<Class>([]), m_bytes);
        }
        
        [Test(description="移動して描画すると3つのコマンドが実行されること")]
        public function shouldExecuteThreeCommandsWithMoving():void
        {
            var expected:Vector.<Class> = Vector.<Class>([
                MoveToCommand,
                DrawRectangleCommand,
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
