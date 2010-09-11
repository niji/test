package com.github.niji.framework.i18n
{
    import com.github.niji.framework.i18n.ITranslator;

	/**
	 * ITranslator を実装したスタブクラス。TranslatorRegistry#install で使うために作られたので、
	 * 本当に何もしない。
	 */	
    public class FakeTranslator implements ITranslator
    {
        public function FakeTranslator()
        {
        }
        
        public function translate(str:String, ...parameters):String
        {
            return null;
        }
    }
}
