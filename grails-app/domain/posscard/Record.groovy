package posscard

class Record {
    String user
    String state
    Date lastTime

    static constraints = {
        user(blank:false, size: 2..10, nullable: false, unique: true)
        state()
        lastTime()
    }
}
