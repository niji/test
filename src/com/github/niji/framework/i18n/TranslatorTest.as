package com.github.niji.framework.i18n
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
        
        [Test(description="TranslatorRegistryはNullTranslatorが入っていること")]
        public function shouldNullTranslatorIsInstalled():void
        {
            Assert.assertTrue(TranslatorRegistry.translator is NullTranslator);
        }
        
        [Test(description="installで上書きするとtranslatorはそのクラスを返す")]
        public function shouldOverrideTranslator():void
        {
            var translator:FakeTranslator = new FakeTranslator();
            TranslatorRegistry.install(translator);
            Assert.assertTrue(TranslatorRegistry.translator is FakeTranslator);
        }
        
        [Test(description="NullTranslatorは少なくともgettext形式の引数を置換する能力を持つ")]
        public function shouldNullTranslatorIsAbleToSubstitute():void
        {
            Assert.assertEquals(
                "This is a test, test2 and test3",
                TranslatorRegistry.tr("This is a %s, %s and %s", "test", "test2", "test3")
            );
        }
    }
}
