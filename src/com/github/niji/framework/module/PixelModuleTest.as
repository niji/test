package com.github.niji.framework.module
{
    import com.github.niji.framework.Recorder;
    import com.github.niji.framework.commands.PixelCommand;
    import com.github.niji.framework.modules.CanvasModuleContext;
    import com.github.niji.framework.modules.ICanvasModule;
    import com.github.niji.framework.modules.PixelModule;
    
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public final class PixelModuleTest
    {
        [Before]
        public function setup():void
        {
            m_bytes = new ByteArray();
            var recorder:Recorder = ModuleTestUtil.createRecorder(m_bytes);
            var context:CanvasModuleContext = new CanvasModuleContext(recorder);
            m_module = context.getModule(PixelModule.PIXEL);
        }
        
        [Test(description="PixelModuleであること")]
        public function shouldBePixelModule():void
        {
            Assert.assertTrue(m_module is PixelModule);
            Assert.assertEquals(m_module.name, PixelModule.PIXEL);
        }
        
        [Test(description="移動せずに描画すると1つのコマンドが実行されること")]
        public function shouldExecuteOneCommandWithoutMoving():void
        {
            var expected:Vector.<Class> = Vector.<Class>([
                PixelCommand
            ]);
            m_module.start(1, 1);
            m_module.stop(1.5, 1.5);
            ModuleTestUtil.assertCommands(expected, m_bytes);
        }
        
        [Test(description="移動して描画すると2つのコマンドが実行されること")]
        public function shouldExecuteTwoCommandsWithMoving():void
        {
            var expected:Vector.<Class> = Vector.<Class>([
                PixelCommand,
                PixelCommand
            ]);
            m_module.start(1, 1);
            m_module.move(2, 2);
            m_module.stop(3, 3);
            ModuleTestUtil.assertCommands(expected, m_bytes);
        }
        
        [Test(description="移動せずドラッグしたまま描画すると1つのコマンドが実行されること")]
        public function shouldExecuteOneCommandWithDragging():void
        {
            var expected:Vector.<Class> = Vector.<Class>([
                PixelCommand
            ]);
            m_module.start(-2, -2);
            m_module.move(-1.5, -1.5);
            m_module.stop(-1, -1);
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
