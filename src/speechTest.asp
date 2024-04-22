<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ses Tanıma ve Metin Dönüştürme</title>
</head>
<body>
<button id="startRecording">Kaydı Başlat</button>
<textarea id="transcription"></textarea>

<script>
// Web Speech API ile desteklenip desteklenmediğini kontrol et
if ('SpeechRecognition' in window || 'webkitSpeechRecognition' in window) {
    var recognition = new webkitSpeechRecognition() || new SpeechRecognition();
    recognition.continuous = true; // Devamlı tanıma modu
    recognition.interimResults = true; // Geçici sonuçlar alma
	recognition.lang = 'tr-TR'; // Tanıma dilini Türkçe olarak ayarla
    // Tanıma başladığında
    recognition.onstart = function() {
        console.log('Kayıt başladı.');
    };

    // Tanıma sonuçları geldiğinde
    recognition.onresult = function(event) {
        var interimTranscript = '';
        var finalTranscript = '';

        for (var i = event.resultIndex; i < event.results.length; ++i) {
            if (event.results[i].isFinal) {
                finalTranscript += event.results[i][0].transcript;
            } else {
                interimTranscript += event.results[i][0].transcript;
            }
        }

        // İlgili div'e metni ekle
        document.getElementById('transcription').innerHTML = finalTranscript;
    };

    // Hata durumunda
    recognition.onerror = function(event) {
        console.error('Hata:', event.error);
    };

    // Tanıma işlemini başlatmak için butona tıklandığında
    document.getElementById('startRecording').addEventListener('click', function() {
        recognition.start();
    });
} else {
    console.error('Üzgünüz, bu tarayıcı bu işlevi desteklemiyor.');
}
</script>
</body>
</html>