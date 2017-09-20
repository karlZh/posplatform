package posscard

class CardBinSupplier {
    static belongsTo = [cardbin:CardBin,supplier: Supplier]
    static constraints = {
    }
}
