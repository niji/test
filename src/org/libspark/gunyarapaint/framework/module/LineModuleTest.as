package org.libspark.gunyarapaint.framework.module
{
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.DrawModuleFactory;
    import org.libspark.gunyarapaint.framework.modules.IDrawable;
    import org.libspark.gunyarapaint.framework.modules.LineModule;

    public class LineModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = Recorder.create(1, 1, 1);
            var context:DrawModuleFactory = new DrawModuleFactory(recorder);
            var module:IDrawable = context.getModule(LineModule.LINE);
            Assert.assertTrue(module is LineModule);
            Assert.assertEquals(module.name, LineModule.LINE);
        }
    }
}
