package org.libspark.gunyarapaint.framework.module
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.modules.CanvasModuleContext;
    import org.libspark.gunyarapaint.framework.modules.ICanvasModule;
    import org.libspark.gunyarapaint.framework.modules.LineModule;

    public class LineModuleTest
    {
        [Before]
        public function setup():void
        {
            m_bytes = new ByteArray();
            var recorder:Recorder = ModuleTestUtil.createRecorder(m_bytes);
            var context:CanvasModuleContext = new CanvasModuleContext(recorder);
            m_module = context.getModule(LineModule.LINE);
        }
        
        [Test]
        public function isLineModule():void
        {
            Assert.assertTrue(m_module is LineModule);
            Assert.assertEquals(m_module.name, LineModule.LINE);
        }
        
        [Test]
        public function drawWithoutMoving():void
        {
            m_module.start(1, 1);
            m_module.stop(1, 1);
            ModuleTestUtil.countCommands(0, m_bytes);
        }
        
        [Test]
        public function drawWithMoving():void
        {
            m_module.start(1, 1);
            m_module.move(2, 2);
            m_module.stop(3, 3);
            ModuleTestUtil.countCommands(3, m_bytes);
        }
        
        [Test]
        public function getLineSegment():void
        {
            ModuleTestUtil.getLineSegment(m_module);
        }
        
        private var m_bytes:ByteArray;
        private var m_module:ICanvasModule;
    }
}
