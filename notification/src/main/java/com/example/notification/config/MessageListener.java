package com.example.notification.config;


import com.example.notification.dto.BatchMessage;
import com.example.notification.dto.PostInsertReq;
import com.example.notification.service.BatchAutogpt;
import com.example.notification.service.PostInsertAutogpt;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;


@Slf4j
@Component
@RequiredArgsConstructor
@RabbitListener(queues = "sample.queue")
public class MessageListener {


    private final PostInsertAutogpt postInsertAutogpt;
    private final BatchAutogpt batchAutogpt;


    @RabbitHandler
    public void receiveMessage(PostInsertReq post) {
        log.info("비동기 post insert 후 autogpt작업 시작");
        //postInsertAutogpt.insert(post);
        log.info(post.toString());

        log.info("비동기 post insert 후 autogpt작업 완료");

    }

    @RabbitHandler
    public void receiveBatchMessage(BatchMessage batchMessage) throws Exception {
        log.info("From Batch to Autogpt start");
        log.info("Message : {}",batchMessage);
        batchAutogpt.insert(batchMessage);
        log.info("From Batch to Autogpt end");
    }

    @RabbitHandler(isDefault = true)
    public void handleDefault(Object message){
        log.info("invoice paid : {} ", message.toString());
    }



}
