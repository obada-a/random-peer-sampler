package de.tum.communication.protocol.messages;

import com.google.common.primitives.Bytes;
import com.google.common.primitives.Ints;
import de.tum.communication.protocol.ByteSerializable;
import de.tum.communication.protocol.MessageType;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Value;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Nicolas Frinker on 12/05/16.
 */

/**
 *  Gossip notification message
 *  see Project specification 3.1.3
 */
@Value
@EqualsAndHashCode(callSuper = true)
public class GossipNotificationMessage extends Message {
    private int dataType;
    private ByteSerializable payload;

    @Builder
    public GossipNotificationMessage(Integer datatype, ByteSerializable payload) {
        super((short) (2 * WORD_LENGTH + payload.getBytes().size()), MessageType.GOSSIP_NOTIFICATION);
        this.dataType = datatype;
        this.payload = payload;
    }

    @Override
    public List<Byte> getBytes() {
        byte[] headerBytes = getHeaderBytes();
        byte[] reservedBytes = new byte[] {0, 0};
        byte[] dataTypeBytes = Ints.toByteArray(dataType);
        List<Byte> byteList = new ArrayList<>(Bytes.asList(Bytes.concat(headerBytes, reservedBytes, dataTypeBytes)));
        byteList.addAll(payload.getBytes());
        return byteList;
    }
}