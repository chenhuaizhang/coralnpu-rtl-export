module DBus2AxiV2_Verification_Assert(
  input [4:0] io_dbus_size,
  input       _GEN,
              io_dbus_valid,
              reset,
              clock
);

  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if (~reset & io_dbus_valid
          & {1'h0, {1'h0, io_dbus_size[0]} + {1'h0, io_dbus_size[1]}}
          + {1'h0,
             {1'h0, io_dbus_size[2]} + {1'h0, io_dbus_size[3]}
               + {1'h0, io_dbus_size[4]}} != {2'h0, _GEN}) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed: Invalid dbus size=%d\n", io_dbus_size);
        if (`STOP_COND_)
          $fatal;
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule
