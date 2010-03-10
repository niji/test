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
            var factory:DrawModuleFactory = new DrawModuleFactory(recorder);
            var module:IDrawable = factory.create(LineModule.LINE);
            Assert.assertTrue(module is LineModule);
            Assert.assertEquals(module.name, LineModule.LINE);
        }
    }
}
