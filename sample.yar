import "hash"

rule Find sample.jpg
{
    meta:
        severity = "critical"
        description = "Found sample.jpg"

    condition:
        hash.sha256(0, filesize) == "9f63d59388aa00c9fbac564c060c4c642739078fa710b807f54d88ebaf33f438"
}
