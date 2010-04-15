package org.libspark.gunyarapaint.framework.i18n
{
    import org.flexunit.Assert;

    public class TranslatorTest
    {
        [After]
        public function tearDown():void
        {
            // should remove FakeTranslator and set default
            TranslatorRegistry.install(new NullTranslator());
        }
        
        [Test]
        public function TranslatorRegistryはNullTranslatorが入っていること():void
        {
            Assert.assertTrue(TranslatorRegistry.translator is NullTranslator);
        }
        
        [Test]
        public function installで上書きするとtranslatorはそのクラスを返す():void
        {
            var translator:FakeTranslator = new FakeTranslator();
            TranslatorRegistry.install(translator);
            Assert.assertTrue(TranslatorRegistry.translator is FakeTranslator);
        }
        
        [Test]
        public function NullTranslatorは少なくともgettext形式の引数を置換する能力を持つ():void
        {
            Assert.assertEquals(
                "This is a test, test2 and test3",
                TranslatorRegistry.tr("This is a %s, %s and %s", "test", "test2", "test3")
            );
        }
    }
}
