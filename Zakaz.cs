//------------------------------------------------------------------------------
// <auto-generated>
//    Этот код был создан из шаблона.
//
//    Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//    Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Shadrin_new
{
    using System;
    using System.Collections.Generic;
    
    public partial class Zakaz
    {
        public int ID { get; set; }
        public Nullable<int> number { get; set; }
        public Nullable<int> client { get; set; }
        public Nullable<int> days { get; set; }
        public string Price { get; set; }
        public Nullable<int> guest { get; set; }
    
        public virtual Guests Guests { get; set; }
        public virtual Room_stock Room_stock { get; set; }
    }
}
